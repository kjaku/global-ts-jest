var rewire = require("rewire");

test("adds", () => {
  expect( rewire("../sum").__get__("sum")(2,3)).toBe(5);
});