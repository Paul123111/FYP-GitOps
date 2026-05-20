# Game Server Fleet

These YAML files set up a game server fleet on worker nodes.

They prioritise filling up the first worker node before moving onto other nodes <br>
because of 'packed' scheduling.

The fleet and its autoscaler live on the infra node or are resources, <br>
the fleet's gameservers are only created on worker nodes.

The autoscaler creates more servers - can be configured here.
