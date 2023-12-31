// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import DepositController from "./deposit_controller"
application.register("deposit", DepositController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import NotificationsController from "./notifications_controller"
application.register("notifications", NotificationsController)

import PasswordVisibilityController from "./password_visibility_controller"
application.register("password-visibility", PasswordVisibilityController)

import DropdownController from "./dropdown_controller"
application.register("dropdown", DropdownController)

import SlimController from "./slim_controller"
application.register("slim", SlimController)
