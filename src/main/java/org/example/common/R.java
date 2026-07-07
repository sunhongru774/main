package org.example.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class R<T> {
    private int code;
    private String message;
    private T data;

    public static <T> R<T> success(T data) {
        return new R<>(200, "success", data);
    }

    public static <T> R<T> success(String message, T data) {
        return new R<>(200, message, data);
    }

    public static <T> R<T> error(int code, String message) {
        return new R<>(code, message, null);
    }

    public static <T> R<T> error(String message) {
        return new R<>(500, message, null);
    }

    public static <T> R<T> unauthorized(String message) {
        return new R<>(401, message, null);
    }

    public static <T> R<T> forbidden(String message) {
        return new R<>(403, message, null);
    }
}
