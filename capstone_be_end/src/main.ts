import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as express from "express"
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors();
  app.use(express.static("."))
  const config = new DocumentBuilder().setTitle("node 37 capstone").addBearerAuth().build()
  const document = SwaggerModule.createDocument(app, config)
  SwaggerModule.setup("/swagger", app, document)
  await app.listen(3000);
}
bootstrap();
