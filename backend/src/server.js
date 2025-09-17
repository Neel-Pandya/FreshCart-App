import app from './app.js';
import connectDB from './core/config/db.config.js';
import EnvConfig from './core/config/env.config.js';
import errorHandler from './core/middleware/error_handler.middleware.js';

connectDB()
  .then(() => {
    app.listen(EnvConfig.appPort, EnvConfig.appHost, () => {
      console.log(`App is running on http://${EnvConfig.appHost}:${EnvConfig.appPort}`);
    });

    app.use(errorHandler);
  })
  .catch((err) => {
    console.log(`Mongo db connection error`, { error: err.message, stack: err.stack });
  });
