# VerifyOrigin

Simple yet effective cross-site request forgery (CSRF) mitigation

## Usage
Include the plug in your application pipeline with a list of valid `Origin` headers

```
plug VerifyOrigin, ["https://example.com"]
```

## Installation

  1. Add verify_origin to your list of dependencies in `mix.exs`:

        def deps do
          [{:verify_origin, "~> 0.0.1"}]
        end

  2. Ensure verify_origin is started before your application:

        def application do
          [applications: [:verify_origin]]
        end

