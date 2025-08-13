package main

import (
	"github.com/gofiber/fiber/v2"
)

func main() {

	webapp := fiber.New(fiber.Config{
		DisableStartupMessage: true,
	})

	webapp.Get("/", func(context *fiber.Ctx) error {
		return context.SendString("Feathery Fast APIs with 🐹 GO Fiber")
	})

	webapp.Listen(":3000")

}
