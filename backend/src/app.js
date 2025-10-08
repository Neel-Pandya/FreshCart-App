import express from 'express';
import cors from 'cors';
import indexRoutes from './index.routes.js';
import cookieParser from "cookie-parser";
import EnvConfig from './core/config/env.config.js';
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser(EnvConfig.cookieSecret));

app.use(
  cors({
    origin: ['http://localhost:3000', 'http://127.0.0.1:3000', 'http://localhost:8080'], // 
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true,
    allowedHeaders: ['Content-Type', 'Authorization'],
  })
);

app.use('/api', indexRoutes);

export default app;
