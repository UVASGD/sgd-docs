# Unity: Unit testing

This article discusses how to get started with unit testing on a Unity project.

### What is unit testing?

[Unit testing](https://en.wikipedia.org/wiki/Unit_testing) is a way of ensuring good code quality by isolating small parts or procedures of the code and testing them individually. As a codebase grows large and complex, it can be useful for preventing regressions (bugs) in future iterations of the same code. Unit testing is often harmonious with [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration), which can include processes to run a test suite automatically whenever changes are made to the code and inform you of any breaking changes. See the [continuous integration wiki article](continuous-integration.md) for details on how to set that up (or, if you use Cloud Build, see below).

## How to run tests

Unity 5 has introduced the [Unity Editor Tests Runner](https://docs.unity3d.com/Manual/testing-editortestsrunner.html), which can be run from within the Unity Editor to produce an overview of results (go to _Window_, then _Editor Tests Runner_, then click on the _Run All_ button). Tests can also be run in "headless" mode from the command line, which is particularly useful for scripting and automation.

If you use [Unity Cloud Build](https://unity3d.com/services/cloud-build), then tests can be run as part of the build. Locate the _Cloud Build_ section of your project online, and then go to _Config_, then for each target, go to _Show Test Options_, then _Edit Test Options_. Check _Enabled_. In most cases you will want to check _Failed Unit Test Fails Build_ as well (this will prevent Cloud Build from creating the build if unit tests fail -- if the testing suite is well crafted, a failure would indicate a buggy build). Keep the method name field the same. After changing the settings, future builds will have test results as part of their logs (go to that build's _Summary_, and then _Tests_ is one of the tabs).

## How to write tests

The option to create an editor test is listed under the Asset creation series of dropdowns (in Unity, go to _Assets_, then _Create_, then _Testing_, then _Editor Test C# Script_). Typically these test files can be grouped under the same subdirectory of a Scripts folder. The template that is used for generating an editor test contains a trivial unit test as an example. Unity adapts the [NUnit framework (version 2.6.4)](http://www.nunit.org/)), which includes several assertion utilities.

At this point it is worth asking **what exactly should be tested**. Games are different from other software projects in a number of ways; one difference is the continuous feedback loop that a game provides which is difficult to simulate in code. Unity's testing framework is not yet mature, so refactoring code that's dependent on this loop such that it's amenable to testing can be more trouble than it's worth. However, there can be parts of your code which make more sense to test, such as:

* Custom data structures or algorithms, e.g. inventory or pathfinding
* Game state logic that isn't too involved with `MonoBehaviour`, e.g. the initial state of an object when it spawns
* Custom event logic, e.g. quest completion triggering a UI element

Oftentimes these parts of code can be designed as an API with inputs and expected outputs. The unit tests will call these APIs with a set of different inputs and then assert that the resultant output is equivalent to the expected output.

### A generic example

Suppose we have a custom math library with a function that calculates the sum of the first `n` natural numbers. We define the class and function below.

```
public class MyMath {
	public static int SumNInts(int n) {
		int sum = 0;
		for (int i = 1; i <= n; i++) {
			sum += i;
		}
		return sum;
	}
}
```

Now, we can write a few tests for this function to verify it works as expected. We will test with the inputs 5, 1, and -3. Note how each test method has a `[Test]` attribute.

```
using NUnit.Framework;

public class MyMathTest {
	[Test]
	public void TestSumNIntsPositive() {
		int sum = MyMath.SumNInts(5);
		Assert.AreEqual(15, sum);
	}
	
	[Test]
	public void TestSumNIntsBase() {
		int sum = MyMath.SumNInts(1);
		Assert.AreEqual(1, sum);
	}
	
	[Test]
	public void TestSumNIntsNegative() {
		int sum = MyMath.SumNInts(-3);
		Assert.AreEqual(0, sum);
	}
}
```

This example is straightforward, but in some cases we may need some common code to set things up before each test. In this case, we can implement another function with `[SetUp]` (as well as another with `[TearDown]` if we need to clean things up after each test). Note that in this example, we made a design decision to return 0 if a negative number was passed into our function. We might have chosen instead to throw an exception; this behavior can also be validated through unit testing with other assertions available in NUnit -- see [the documentation](http://www.nunit.org/index.php?p=docHome&r=2.6.4) for more details.

### Working with the Unity framework

Now let's bring in Unity-specific material. As noted before, it is difficult to have tests simulate gameplay scenarios such as objects colliding or the player clicking on a button (this would in theory be covered by [integration tests](https://en.wikipedia.org/wiki/Integration_testing), which Unity does not yet natively support), but we can have tests check if certain pieces of collision or UI behavior are correct, among other things.

One starting point is verifying initial conditions of a `GameObject` and its `MonoBehaviour`. Suppose we have a behavior defined as follows:

```
public class ObservePlayer : MonoBehaviour {
	public GameObject player;
	void Start() {
		this.player = GameObject.FindGameObjectWithTag ("Player");
	}
}
```

Let's write a test that validates that the behavior finds the correct object when the scene starts up. We'll start out like this:

```
[Test]
public void TestObservePlayerFindsPlayerObject() {
	var player = new GameObject();
	player.tag = "Player";

	var observer = new GameObject();
	observer.AddComponent<ObservePlayer>();
	
	Assert.AreEqual(observer.player.GetInstanceID(), player.GetInstanceID());
}
```

If we run this test, it should fail, because the `Start` method was never called in `ObservePlayer`.  Editor tests have no native way of controlling the `GameObject` lifecycle (i.e. calling the various methods associated with creating, updating, and deleting objects); however, we can code around that with some [C# extension methods](https://docs.microsoft.com/en-us/dotnet/articles/csharp/programming-guide/classes-and-structs/extension-methods) that utilize [reflection](https://msdn.microsoft.com/en-us/library/system.reflection(v=vs.110).aspx).

See [TestHelper.cs](https://github.com/SebastianJay/unity-ci-test/blob/master/UnityProject/Assets/Scripts/Editor/TestHelper.cs) for a simple way to manually invoke the `GameObject` lifecycle methods. If we include that script in our test assembly, and change the `AddComponent` line in the above test to:

```
observer.AddComponentAndInit<ObservePlayer>();
```

Then, `Start` should be invoked when the component is added, and the test may pass (read on to fix one more pitfall).

Another issue with editor tests is that they run within the scene that is currently open, rather than an empty scene as we might expect. This means that if we run the above test in a scene where a player object already exists, then it is possible for the test to fail because `FindGameObjectWithTag` could find that existing player object rather than the one which was created in the test method. We can work around this by opening a blank scene before running any tests. See [TestConfig.cs](https://github.com/SebastianJay/unity-ci-test/blob/master/UnityProject/Assets/Scripts/Editor/TestConfig.cs) for a simple way of doing that (just include the script in the test assembly) -- the script will create and open a new blank scene before any tests are run, and then return the editor to the active scene when they are finished. If we use this script, then our test should pass.

This should be a good starting point for you to begin creating your own tests. It is likely that as your codebase grows larger, your testing framework (i.e. scripts you'll write to simplify matters) will also get slightly more complex. Just remember to stay disciplined -- even though it is decidedly unexciting to write unit tests, they will end up preventing many bugs and saving lots of time in the long run.

[Back](./index.md)
