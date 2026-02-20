const express = require("express");
const cors = require("cors");
const db = require("./db");

const app = express();
app.use(cors());
app.use(express.json());

app.get("/api", (req, res) => {
  db.query("SELECT NOW() as time", (err, results) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({
      message: "Backend → RDS successful",
      db_time: results[0].time
    });
  });
});

app.listen(8080, () => {
  console.log("🚀 Backend running on port 8080");
});