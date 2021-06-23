const express = require("express")
const router = express.Router()
const Order = require("../models/order")

router.get("/", async (req, res, next) => {
    try {
      const orders = await Order.listOrdersForUser(req.body)
      return res.status(200).json({ orders })
    } catch (err) {
      next(err)
    }
  })

router.post("/", async (req, res, next) => {
  try {
    const order = await Order.createOrder(req.body)
    return res.status(200).json({ order })
  } catch (err) {
    next(err)
  }
})

module.exports = router
