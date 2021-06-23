const { UnauthorizedError } = require("../utils/errors")
const { SECRET_KEY } = require("../config")
const jwt = require("jsonwebtoken")

// It should take in in a request object and checks to see if the request has an authorization header.
//  If it does, extract the token from the header.
//  Authorization headers look like this: "Authorization": "Bearer ${token}".
//  That function should return the token if it exists, otherwise it should return null.
function jwtFrom({ header }){
    if (headers?.authorization){
        const [scheme,token] = headers.authorization.split(" ")
        if (scheme.trim() === "Bearer"){
            return token
        }
    }
    return undefined
}

 //The function signature should take in the request, the response, and the next function.
//  Use the jwtFrom function to extract the JWT token from the Authorization header
//  Use the jsonwebtoken package to verify the token and extract the user
//  Attach that user to the response's locals property at res.locals
const extractUserFromJwt = (req,res,next) =>{
    try{
        const token = jwtFrom(req)
        if (token) {
            res.locals.user = jwt.verify(token,SECRET_KEY)
        }
        return next()
    }catch(err){
        return next()
    }
}

 //The function signature should take in the request, the response, and the next function.
//  It should check to see if the user exists on res.locals and that the user has an email.
//  If none exists, throw an UnauthorizedError

const requireAuthenticatedUser = (req,res,next) =>{
    try{
        const { user } = res.locals
        if(!user?.email){
            throw new UnauthorizedError()
        }
        return next()
    }catch(err){
        return next(err)
    }
}

module.export = {
    jwtFrom,
    extractUserFromJwt,
    requireAuthenticatedUser
}