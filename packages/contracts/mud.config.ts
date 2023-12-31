import { mudConfig } from "@latticexyz/world/register";
 
export default mudConfig({
  enums: {
    TerrainType: ["None", "TallGrass", "Boulder"],
  },
  tables: {
    MapConfig: {
      keySchema: {},
      dataStruct: false,
      valueSchema: {
        width: "uint32",
        height: "uint32",
        terrain: "bytes",
      },
    },
    Movable: "bool",
    Obstruction: "bool",
    Player: "bool",
    Position: {
      dataStruct: false,
      valueSchema: {
        x: "uint32",
        y: "uint32",
      },
    },
  },
});