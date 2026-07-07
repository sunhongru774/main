package org.example.dto;

import lombok.Data;

@Data
public class AIChatDTO {
    private String message;
    private java.util.List<String> history;
}
