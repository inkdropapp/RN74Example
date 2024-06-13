package com.rn74example

import android.util.Log
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.UiThreadUtil
import com.facebook.react.module.annotations.ReactModule
import com.reactnativecommunity.webview.RNCWebViewWrapper

@ReactModule(name = AttachmentProcessorModule.NAME)
class AttachmentProcessorModule(reactContext: ReactApplicationContext)
     : NativeAttachmentProcessorSpec(reactContext)
{
    private val reactContext: ReactApplicationContext = reactContext

    override fun getName(): String {
        return NAME
    }

    override fun process(tag: Double, promise: Promise) {
        Log.v("attachment", reactContext.toString())
        UiThreadUtil.runOnUiThread {
            val view = reactContext.fabricUIManager?.resolveView(tag.toInt()) as RNCWebViewWrapper
            if (view != null) {
                val webView = view.webView
                Log.v("webview??", webView.toString())
                webView.evaluateJavascript("alert('hello')", null)
            }
        }
    }

    companion object {
        const val NAME = "AttachmentProcessor"
    }
}


