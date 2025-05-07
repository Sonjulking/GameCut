package com.gamecut.util;

import javax.servlet.http.Cookie;

public class MyCookie {
    public static String getValue(Cookie[] arr, String name) {
        String value = null;
        for (Cookie c : arr) {
            if (c.getName().equals(name)) {
                value = c.getValue();
            }
        }
        return value;
    }
}
