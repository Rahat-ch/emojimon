// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;
 
import { System } from "@latticexyz/world/src/System.sol";
import { MapConfig, Movable, Obstruction, Player, Position } from "../codegen/index.sol";
import { addressToEntityKey } from "../addressToEntityKey.sol";
import { positionToEntityKey } from "../positionToEntityKey.sol";
 
contract MapSystem is System {
  function spawn(uint32 x, uint32 y) public {
    bytes32 player = addressToEntityKey(address(_msgSender()));
    require(!Player.get(player), "already spawned");
 
    bytes32 position = positionToEntityKey(x, y);
    require(!Obstruction.get(position), "this space is obstructed");
 
    Player.set(player, true);
    Position.set(player, x, y);
    Movable.set(player, true);
  }
 
  function moveBy(uint32 clientX, uint32 clientY, int32 deltaX, int32 deltaY) public {
    bytes32 player = addressToEntityKey(_msgSender());
    require(Movable.get(player), "cannot move");
 
    (uint32 fromX, uint32 fromY) = Position.get(player);
    require(distance2(deltaX, deltaY) == 1, "can only move to adjacent spaces");
    require(clientX == fromX && clientY == fromY, "client confused about location");
 
    uint32 x = uint32(int32(fromX) + deltaX);
    uint32 y = uint32(int32(fromY) + deltaY);
 
    bytes32 position = positionToEntityKey(x, y);
    require(!Obstruction.get(position), "this space is obstructed");
 
    Position.set(player, x, y);
  }
 
  function distance2(int32 deltaX, int32 deltaY) internal pure returns (uint32) {
    return uint32(deltaX * deltaX + deltaY * deltaY);
  }
}