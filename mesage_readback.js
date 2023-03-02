import React, { useEffect } from 'react';
import { View, Button, Text } from 'react-native';
import Tts from 'react-native-tts';

const MyComponent = () => {

  useEffect(() => {
    Tts.getInitStatus().then(() => {
      Tts.setDefaultLanguage('en-US');
    });
  }, []);

  const handleSpeak = () => {
    Tts.speak('Hello, world!', {
      iosVoiceId: 'com.apple.ttsbundle.Moira-compact',
      rate: 0.5,
      androidParams: {
        KEY_PARAM_PAN: -1,
        KEY_PARAM_VOLUME: 0.5,
        KEY_PARAM_STREAM: 'STREAM_MUSIC',
      },
    });
  };

  const handleStop = () => {
    Tts.stop();
  };

  const handleGetVoices = () => {
    Tts.voices().then((voices) => {
      console.log(voices);
    });
  };

  return (
    <View>
      <Button title="Speak" onPress={handleSpeak} />
      <Button title="Stop" onPress={handleStop} />
      <Button title="Get Voices" onPress={handleGetVoices} />
    </View>
  );
};

export default MyComponent;
