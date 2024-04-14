import { Controller, Post, Body, Req, Query } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInForm, UserForm } from './userDto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags("Auth")
@Controller('api')
export class AuthController {
  constructor(private readonly authService: AuthService) { }

  @Post('signup')
  signUp(@Body() userData: UserForm) {
    return this.authService.create(userData)
  }
  @Post('login')
  login(@Body() user: SignInForm) {
    return this.authService.login(user);
  }
}
