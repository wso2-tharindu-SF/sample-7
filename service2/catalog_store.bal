// The fixed, seeded ten-record catalog (Product Decisions: Catalog data).
// Scores sum to exactly 350 — the full-catalog average, computed by service1,
// is 35 (350 / 10, discarding any remainder).
final Record[] seedCatalog = [
    {id: 1, name: "Widget Alpha", score: 10},
    {id: 2, name: "Widget Beta", score: 20},
    {id: 3, name: "Widget Gamma", score: 30},
    {id: 4, name: "Widget Delta", score: 40},
    {id: 5, name: "Widget Epsilon", score: 50},
    {id: 6, name: "Widget Zeta", score: 15},
    {id: 7, name: "Widget Eta", score: 25},
    {id: 8, name: "Widget Theta", score: 35},
    {id: 9, name: "Widget Iota", score: 45},
    {id: 10, name: "Widget Kappa", score: 80}
];

// Starting mode is full (Product Decisions: Starting mode).
string catalogMode = "full";

// Returns the catalog currently in effect for the active mode.
function currentCatalog() returns Record[] {
    if catalogMode == "empty" {
        return [];
    }
    return seedCatalog;
}

// Switches the active mode. The caller validates the value first.
function setCatalogMode(string mode) {
    catalogMode = mode;
}
