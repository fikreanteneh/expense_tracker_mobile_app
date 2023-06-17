const express = require("express");
const expenseRouter = express.Router();

const { createExpense, getExpenseData, updateExpense, deleteExpense } = require("../controllers/expense");


expenseRouter.get("/:id", getExpenseData);
expenseRouter.post("/post", createExpense);
expenseRouter.put("/update", updateExpense);
expenseRouter.delete("/:id", deleteExpense);



module.exports = expenseRouter;
