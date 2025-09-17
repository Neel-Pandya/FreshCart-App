import express from 'express';
import cors from 'cors';
import indexRoutes from './index.routes.js';
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(
  cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true,
  })
);

app.use('/api', indexRoutes);

export default app;
