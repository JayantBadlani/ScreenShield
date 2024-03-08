//import libraries
import React from 'react';
import {Button, Platform, StyleSheet, Text, View} from 'react-native';
import protectScreenRecording from './nativeModules/screenShieldRN';
// create a component
const App = () => {
  return (
    <View style={styles.container}>
      {Platform.OS === 'ios' ? (
        <Button title="Protect me" onPress={protectScreenRecording} />
      ) : (
        <Text>Only available for iOS</Text>
      )}
    </View>
  );
};

// define your styles
const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

//make this component available to the app
export default App;
