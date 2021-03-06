#!/bin/bash

mkdir ~/.ssh/
chown -R $USER:$USER ~/.ssh/
chmod 700 ~/.ssh/

echo "
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAEAQDUgkbTvAo+LzUmroLfB4Mq0ciZ355Rm4E9yDBYbaWJXeo/eknOOm6tqjJ5zGWU20yXFNbGJrt9Fpx1IPTK5ZsPCFSguxqg9KK9OMOAuwk1Cc/wVz35aF9VRCZHbSmMvMW9riEN94YmTxDs9kpSSYkmZKIJeHC3SkNglIkni8K8Fz/UMojvTm6pSuF0TDTeqZUpE7sPA0Qr4fm8WZQcqQPgicU61rmcI/bXh1h/x0tuK09Ee1hiCArkmwmoWMACOmTmM1KXd96QefykZGxXyPQDnxodU/nhs9GAlCe46yyx0akyH4WPuIcQfxcDWS7TbUE6SC1BV32yS59K3zbGuAdUceof7wgZ0Mi7+wcrw6VQpHzXtXw0MSnN401yKSeHJw/grhzOD2/HDvGwFqTpIRrir3VbMJGYPCPltNCZ6zON4C4LVekYbdG7vztxNINxzhQnW4JrUoZaUpiQfl02PHLPLp++X6FI4Fno0nozv7Esl3ukLuyxHpWabgjHJLQlAqB2lISLouWDLsNHgI/6IkON6caXAGk44puhIEDQ4Vgo9FPgoihaW4O0mn+/3oJ9rW2hAt9ofJb1VZjliV/df+7MaAFbg3RIPG2NGd1jAluAzMzjfg8z5cYsSlUhQ3fDGCfk2L8wXFkcb5PAp8r2hWX4lnF93W6tMPbZ83o9cYQ3H5l5kq/593nsy4nit5F8v9/0wyM0w6/SeSFsRbeQjTuuJZtZ+iMT+s+gTn00riAndCSgwV2EG01V1jCiVwFHrwWNZ3qRTkqFE+79s3f71pkM4iEMD+HyeJBP0ekmMjTUCI/j0BR/Mvz7suMWQWFYS0abX6TlTQNbjvmbjkGsX9XeiksftSat+w0Vj3+vWmiuJBbCijiFHpuV3ez0RJX7UIoS4kHggbqfmxxzPSnx1wHmHZiWhnMUQkqCHwDGe7aCzeWW2Sv5OPBBfy3Rkx5uWfZNM7hkBrLwIEZdIJOauhdaAF0kT1Wnc1KqTcdzNZvG90TPx/dWN0pCPzpnhloNj36qDAlgr8WaKaUO8JvRX6d6+yc3tRrlUrfDxX9HvgWjy2fxpnxcVwrq8aSSb+CJWJxJpsxV2JCjnWQpO42fVN9Z6iedGMeJx05zDXinsGyF7qicyM9bpUyFljjSneVNJwGtRRFV+oVe2ofVwWoBEqFjMePMz6zM1VV5ZbYxlqXJjIGAUtWtSJNsgZ+s69ENaTcC5FhfVy5F0t7yVYBE90AsQAE4K0C0tO7RxFmaCbpU6GWOTgPX00uRpeC0k+1J6k7E1XMEgP2BHHo0hCo6j3A4EAObAfl3M0HXrU+5aCHp0011/jgmM7XB+eyrkagloDi30xaXLol9WPxoiSYUDdQH 0

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCxo4+bVHpL2T27mMfwsRsavZ4kRA4hxQqI+RGY1iUVil0cztZ08lwawx4OGaEFrFiW3nYRhwMFlkTv9VzODRQYEYOjVfTuHo1kDodbaeWzNbO7I3TDHc/WCQMPxX+tnfKvxjkjSBgKYMBJLcCxQAUdOEqucEur7NjsoZ+dj8PZuifH8op12gv3LtfmkPD6Lf8ZDhKq0LbeYGxf6NlIShmyxjSW5krWX+aMiM7Ori/AFimb1m8w6H8zJyeUiVLBpyOLjBFZ/HYexB+jz9unu9TDSEF5VmFV9jpvAaR4U5pxXlLzCgLB4M/cAcGhlZvxXv374K8cNQ0UP8ZKHo6r/IuOtGctuJMmqeWQ0d6Z3Ylk8Fykt77wr4kAIYxnPHO9+xtB45V0YXd4rUzXOUFXBDQGIFYPx8kR3Geo8E8KLNZm6DgPqtIaV9Fh/vf86z6W93/YuKzz5ZAg8J6yABzJKi4UhOSgVccWfhhV0OZoKjE5cjKHmSdz1vEAG0EmitTSs0PSNJS3SIBgS6U5PNuxfu3f/xDnfA+vM1XBMUcL7oCw24pZFq5Z6KGIzyWTEIKVx+J3SMnayP1lvzA5CaiViAyXauKRTOmgVXMXXDr1GhDcS+RrDKOCGyNako+vZmPtZEfscVl7wkgpUINzRiP9CXQsKQ0UtAWRWUvMu+GKiWwpzw== z

" >> ~/.ssh/authorized_keys

chmod 600 ~/.ssh/authorized_keys
