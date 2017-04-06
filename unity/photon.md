# Photon Unity Networking

This article discusses setting up Photon with a Unity project to enable networked multiplayer games.

## Initial Setup Process

In order to set up Photon Unity Networking (PUN) for the first time, follow the [Initial Setup](https://doc.photonengine.com/en-us/pun/current/getting-started/initial-setup) instructions (Note: To import, go to the Assets Store and download. Demos will be included and are documented [here](https://doc.photonengine.com/en-us/pun/current/getting-started/pun-intro) under the Manuals and Demos section).

## Getting the Basics

Your Unity project should now contain a folder called _Photon Unity Networking_. This folder contains a subfolder called _Utility Scripts_. Here you can find all of the basic functionalities of a multiplayer game implemented using Photon. For example, [SuperStellar](https://github.com/UVASGD/spring-2017-superstellar) uses the `Connect and Join Random` script allows players to join the game straight from the start screen. Looking at these scripts is a great way to start understanding the fundamentals of PUN, as they are well documented, have intuitive names, and are usually very useful in setting up a barebones multiplayer game.

## General Structure

[This Stack Overflow post](http://stackoverflow.com/questions/37743191/when-to-use-photon-networking-master-client) gives an idea of what the Photon server does. Essence: all game logic is farmed out to some client. All clients are capable of handling all game logic. Master client assigning is robust.

## Creating a Network GameObject

In order to keep track of the network setup required for a multiplayer game, we strongly suggest you create a `GameObject` called `Network` that has the necessary scripts attached. These scripts include the network connection script (like `Connect and Join Random`) and another built-in script called `OnJoinedInstantiate`. The `OnJoinedInstantiate` allows you to add players to the game when they have joined a room and are ready to play. There are other scripts that will also allow you to do this (or you could make one yourself), but we found that this script served most of our purposes.  In the Unity editor, you can specify where you would like to spawn players and provide the `Player` Prefab (creation described below) to instantiate. Having these base scripts in one `GameObject` simplifies the debugging process and using built-in scripts simplifies the network setup process significantly.

## Making a Player

Since multiplayer games usually use multiple of the same type of player en masse, the first thing you need to do is make a `Player` Prefab. To do this, create a new `GameObject` in your Unity scene. Then, click and drag the new `GameObject` into your _Resources_ folder. From here on out, it is good practice to directly edit the Prefab in the _Resources_ folder to make sure the changes you make are applied in game when you use it. Now, we have to add a few components to our Prefab to allow it to communicate over the multiplayer network. The first thing we need to add is a `PhotonView`. This script component allows us to use RPCs (which we will discuss later) and communicate information over the network. Add a `PhotonView` by clicking on "Add Component" and search for `PhotonView`. You can leave the component as is for now, but we will add an Observed Component later. Now your Prefab is able to send information, but `PhotonView` does not track the movement of the player. In order to synchronize player movement, rotation, and scale across all clients, you must add a `Photon Transform View`. You can add this component similarly to a `PhotonView`. After adding this component, we need to add it to the `PhotonView`'s Observed Components. Now your player is able to send RPCs and we can track its movement over the network, meaning it is ready for multiplayer. In order to understand the details of this component, I recommend looking at the [documentation](https://doc.photonengine.com/en-us/pun/current/tutorials/pun-basics-tutorial/player-networking#trans_sync) (Transformation Synchronization section).

### Side Tips

* We have found that best movement tracking is achieved by setting the `Interpolate Option` for `Synchronize Position` to "Estimated Speed" and the `Extrapolate Option` to "Synchronize Values".
* If you have changed the scale of your prefab, you must check the `Synchronize Scale` option to maintain the scale you have set.
* While the documentation PUN provides was not useful to us because we made a 2D game, the player creation for a 3D game is described quite well [here](https://doc.photonengine.com/en-us/pun/current/tutorials/pun-basics-tutorial/player-prefab).

## Remote Procedure Calls (RPCs)

To learn in detail what an RPC is, look at the documentation [here](https://doc.photonengine.com/en-us/pun/current/manuals-and-demos/rpcsandraiseevent). To summarize the documentation, RPCs allow you to apply normal methods to tell all connected players about remote events. 

### Implementation

A detailed guide to implementation can be found [here](https://doc.photonengine.com/en-us/pun/current/manuals-and-demos/rpcsandraiseevent), but we will attempt to break it down more in this document. The first thing you must set up when trying to use RPCs is make the script your method is in inherit from `Photon.MonoBehaviour` (i.e. `public class YourBehaviour : Photon.MonoBehaviour`). The second setup step is to add the attribute `PunRPC` before the method (just put `[PunRPC]` before your method declaration). Now you can invoke the method you added this attribute to as an RPC method.

### Invocation

An RPC can only be called on an object's `PhotonView` (i.e. `yourPhotonView.RPC()`). This invocation means that whatever action you specify in the RPC call will be applied to the object which `yourPhotonView` belongs to. Usually, we specify that the RPC should apply to all other `PhotonView`s/`Player`s in the room by using the parameter `PhotonTargets.All`, however `.All` can be replaced with other extensions specified in the [documentation](https://doc.photonengine.com/en-us/pun/current/manuals-and-demos/rpcsandraiseevent). After you specify `PhotonTargets`, you can specify method parameters. Note that `GameObject`s cannot be passed into RPC methods and are discussed below in "Tag Systems". If anything described above is unclear to you, we strongly recommend you refer to the documentation provided above, as it shows a code snippet which we found useful.

### Management

Since a multiplayer game will primarily communicate information using RPCs, you must ensure that each client cannot make any local changes that it is not supposed to make. By default, a client is allowed to access and manipulate all other players' behaviour, because all of the necessary components are left enabled. In order to prevent this, we must include checks in each of our player specific scripts to prevent this inconsistency. To do this, add either of the two following code snippets before your first method:

```
void OnEnable()
{
	if (this.photonView != null && !this.photonView.isMine) 
	{
		this.enabled = false;
		return;
	}
}

void Start()
{
	if (this.photonView != null && !this.photonView.isMine) 
	{
		this.enabled = false;
		return;
	}
}
```

The `if` statement checks if the current object has a `PhotonView` attached to it and if the `PhotonView` does not belong to the local player using the built in `.isMine` property. If the `PhotonView` does not belong to us, the script must be intended to manipulate another player's movement. Therefore, we disable it so we are not able to access and manipulate the other player's information.

[Back](./index.md)