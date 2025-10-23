package com.inventory.InventoryWeb;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String username,
                          @RequestParam String password,
                          Model model) {

        // Temporary Authentication
        if(username.equals("admin") && password.equals("admin123")) {
            return "redirect:/home";
        } else {
            model.addAttribute("error", true);
            return "login";
        }
    }

    @GetMapping("/home")
    public String homePage() {
        return "home"; // You can create home.html
    }
}

