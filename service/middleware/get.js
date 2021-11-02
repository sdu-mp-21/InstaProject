const router = require('express').Router()
const jwt = require('jsonwebtoken')
const fs = require('fs')

const User = require('../models/users')
const Publication = require('../models/publications')

router.get('/profile', async (req, res) => {
    try {
        const verify = jwt.verify(req.query.token, 'auth')
        if (verify) {
            const user = await User.findOne({ userId: verify.userId })
            const publications = await Publication.find({ userId: verify.userId, type: 'publication' })
            const pubs = []

            for (let publication of publications) {
                try {
                    const publicationName = publication.name
                    var myBuffer = new Buffer(publication.data.length);
                    for (var i = 0; i < publication.data.length; i++) {
                        myBuffer[i] = publication.data[i];
                    }

                    if (!fs.existsSync(`./publications/${publicationName}.png`)) {
                        fs.writeFileSync(`./publications/${publicationName}.png`, myBuffer)
                    }

                    pubs.push({ src: `http://localhost:5000/get/images/${publication.publicationId}` })
                } catch (e) {
                    console.log(e)
                }
            }

            res.status(200).send({
                publications: pubs,
                userId: user.userId,
                login: user.login,
                name: user.name,
                surname: user.surname,
                site: user.site,
                phoneNumber: user.phoneNumber,
                email: user.email,
                aboutMe: user.aboutMe,
                avatar: user.avatar
            })

        } else {
            res.status(401).send({ message: 'Вы не авторизованы' })
        }
    } catch (e) {
        console.log(e)
        res.sendStatus(500)
    }
})

router.get('/images/:publicationId', async (req, res) => {
    const { publicationId } = req.params
    if (publicationId) {
        const publication = await Publication.findOne({ publicationId })

        if (publication) {

            fs.writeFile(`./publications/${publication.name}.png`, publication.data, () => {
                res.download(`./publications/${publication.name}.png`)
            })

        } else {
            res.status(404).send()
        }

    } else {
        res.status(400).send()
    }

})

module.exports = router