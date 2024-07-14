import { authMiddleware } from '@global/helpers/auth-middleware';
import { currentUserRoutes } from './features/auth/routes/currentRoutes';
import { serverAdapter } from '@service/queues/base.queue';
import { authRoutes } from './features/auth/routes/authRoutes';
import { Application } from 'express';
import { postRoutes } from '@post/routes/postRoutes';
import { reactionRoutes } from '@reaction/routes/reactionRoutes';

const BASE_PATH = '/api/v1';

export default (app: Application) => {
  const routes = () => {
    app.use('/queues', serverAdapter.getRouter());
    app.use(BASE_PATH, authRoutes.routes());
    app.use(BASE_PATH, authRoutes.signoutRoute());

    app.use(BASE_PATH, authMiddleware.verifyUser, currentUserRoutes.routes());
    app.use(BASE_PATH, authMiddleware.verifyUser, postRoutes.routes());
    app.use(BASE_PATH, authMiddleware.verifyUser, reactionRoutes.routes());
  };
  routes();
};
