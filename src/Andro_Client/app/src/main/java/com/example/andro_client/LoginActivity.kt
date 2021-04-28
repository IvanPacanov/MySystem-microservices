package com.example.andro_client

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView

class LoginActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        findViewById<TextView>(R.id.textViewSignUp).
        setOnClickListener(View.OnClickListener {
            startRegisterActivity();
        })

        findViewById<TextView>(R.id.forgotPassword).
        setOnClickListener(View.OnClickListener {
            startForgotPasswordActivity();
        })

        findViewById<Button>(R.id.bntlogin).
        setOnClickListener(View.OnClickListener{
                    startMainActivity();
                })
    }

    private fun startRegisterActivity()
    {
        startActivity(Intent(this, RegisterActivity::class.java));
    }

    private fun startForgotPasswordActivity()
    {
        startActivity(Intent(this, PasswordForgotActivity::class.java));
    }

    private fun startMainActivity()
    {
        startActivity(Intent(this, MainActivity::class.java));
    }
}