const connection = require("../config/dbconnection");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

const signUp = async (req, response) => {
  console.log(req.body);
  try {
    const { username, password } = req.body;
    // Hash password
    const hashedPassword = await bcryptjs.hash(password, 8);
    const query1 = `INSERT INTO account (username, password) VALUES ("${username}","${hashedPassword}")`;

    // Insert the user into account table
    connection.query(query1, (err, result) => {
      if (err) {
        return response.status(500).json({ error: "Internal server error" });
      }
    });

    // Get the user id from account table by phone number
    const query2 = `SELECT id FROM account WHERE username = '${username}'`;
    connection.query(query2, (err, result) => {
      if (err) {
        return response.status(500).json({ error: "Internal server error" });
      }

      const id = result[0].id;
      const payload = { id: id };
      const token = jwt.sign(payload, "secret-token-key");
      return response.status(200).json({ username: username, token: token });
    });
  } catch (error) {
    return response.status(500).json({ error: error.message });
  }
};

const signIn = async (req, res) => {
  console.log(req.body);
  try {
    const { username, password } = req.body;
    const query = "SELECT * FROM account WHERE username = ?";
    connection.query(query, [username], async (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Internal server error" });
      }

      if (!result[0]) {
        return res.status(400).json({ error: "Username doesn't exists" });
      }

      const isMatch = await bcryptjs.compare(password, result[0].password);

      if (!isMatch) {
        return res.status(400).json({ error: "Incorrect password" });
      }

      const payload = { id: result[0].id, role: result[0].role };
      const token = jwt.sign(payload, "secret-token-key");
      const response = { username: username, token: token };
      return res.status(200).json(response);
    });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
};

module.exports = {
  signIn,
  signUp,
};
