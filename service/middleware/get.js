const router = require('express').Router()
const User = require('../models/users')
const jwt = require('jsonwebtoken')
const fs = require('fs')

router.get('/profile', async (req, res) => {
    console.log(req.query)
    try {
        const verify = jwt.verify(req.query.token, 'auth')
        if (verify) {

            const user = await User.findOne({ userId: verify.userId })
            res.status(200).send(user)

        } else {
            res.status(401).send({ message: 'Вы не авторизованы' })
        }
    } catch (e) {
        res.sendStatus(500)
    }
})

router.get('/images/:imageName', async (req, res) => {
    const { imageName } = req.params
    if (req.params.imageName) {
        const isExists = fs.existsSync('images/' + imageName)

        if (isExists) {
            res.send(fs.readFileSync('images/' + imageName))
        }
    }

})

module.exports = router