import EnvConfig from "./env.config.js";

const cookieOptions = {
    httpOnly: true,
    secure: EnvConfig.nodeEnv === 'production',
    sameSite: EnvConfig.nodeEnv === 'production' ? 'None' : 'Lax',
    signed: false,
}

export default cookieOptions;