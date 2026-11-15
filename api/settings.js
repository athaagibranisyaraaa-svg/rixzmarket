import {db,jsonError} from "./_lib.js";
export default async function handler(req,res){if(req.method!=="GET")return res.status(405).json({error:"Method not allowed"});try{const {data,error}=await db().from("site_settings").select("key,value");if(error)throw error;res.status(200).json({settings:Object.fromEntries((data||[]).map(x=>[x.key,x.value]))});}catch(e){jsonError(res,e);}}
