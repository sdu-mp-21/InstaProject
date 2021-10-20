const express = require('express')
const router = express.Router()

router.use('/api/auth', require('../middleware/auth'))
router.use('/get', require('../middleware/get'))
router.use('/upload', require('../middleware/upload'))
router.use('/search', require('../middleware/search'))

module.exports = router