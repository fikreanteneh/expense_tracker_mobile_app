const express = require("express");
const authRouter = express.Router();
const { signIn, signUp } = require("../controllers/auth");

// user signup
authRouter.post("/signup", signUp);

// user signin
authRouter.post("/signin", signIn);

module.exports = authRouter;
