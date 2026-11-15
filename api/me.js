import {getUser,jsonError} from "./_lib.js";
export default async function handler(req,res){if(req.method!=="GET")return res.status(405).json({error:"Method not allowed"});try{const u=await getUser(req);if(!u)return res.status(401).json({error:"Unauthorized"});res.status(200).json(u);}catch(e){jsonError(res,e);}}
