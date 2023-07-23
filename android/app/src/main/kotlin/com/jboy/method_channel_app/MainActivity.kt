import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/dateAndTime"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "getDateAndTime") {
                val dateAndTime = getDateAndTime()

                if (dateAndTime != null) {
                    result.success(dateAndTime)
                } else {
                    result.error("UNAVAILABLE", "Date and Time not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getDateAndTime(): String? {
        val sdf = SimpleDateFormat("EEEE, MMMM d, yyyy 'at' h:mm a", Locale.US)
        return sdf.format(Date())
    }
}
