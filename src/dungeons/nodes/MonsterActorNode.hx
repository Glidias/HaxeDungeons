package dungeons.nodes;

import ash.core.Node;

import dungeons.components.MonsterAI;
import dungeons.components.Actor;

class MonsterActorNode extends Node<MonsterActorNode>
{
    public var actor:Actor;
    public var ai:MonsterAI;
}
