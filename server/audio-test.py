from pydub import AudioSegment

# Load recording
sound = AudioSegment.from_file("call.m4a", format="m4a")

# Save as wav for testing
sound.export("call.wav", format="wav")

print("✅ Converted to call.wav, open it with VLC or any player.")
