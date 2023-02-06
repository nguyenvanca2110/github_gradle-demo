package com.example.gradledemo.controller;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.net.InetAddress;
import java.net.UnknownHostException;

@RestController
@RequestMapping("/")
public class WelcomeResource {

    @GetMapping(value="greetings", produces = MediaType.APPLICATION_JSON_VALUE )
    public String greetings(){
        return "Welcome To Gradle 2!";
    }

    @GetMapping("/local")
    public String getLocalIp() throws UnknownHostException {
        InetAddress inetAddress = InetAddress.getLocalHost();
        String localIp = inetAddress.getHostAddress();
        return "Local IP address : " + localIp;
    }
}
