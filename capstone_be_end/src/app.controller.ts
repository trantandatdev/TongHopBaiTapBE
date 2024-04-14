import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) { }
}
