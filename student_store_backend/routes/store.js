const express = require("express")
const router = express.Router()

router.get("/", async (req, res, next) => {
  try {
    const products = await Store.listProducts(req.body)
    return res.status(200).json({ products })
  } catch (err) {
    next(err)
  }
})

module.exports = router