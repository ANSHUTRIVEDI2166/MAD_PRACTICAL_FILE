import React, { useEffect, useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet } from 'react-native';
import { getUserProfile, updateUserProfile } from '../database/sqlite';

const ProfileScreen = () => {
    const [userProfile, setUserProfile] = useState({
        name: '',
        email: '',
    });

    useEffect(() => {
        const fetchProfile = async () => {
            const profile = await getUserProfile();
            setUserProfile(profile);
        };
        fetchProfile();
    }, []);

    const handleInputChange = (name, value) => {
        setUserProfile({ ...userProfile, [name]: value });
    };

    const handleUpdateProfile = async () => {
        await updateUserProfile(userProfile);
        alert('Profile updated successfully!');
    };

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Profile</Text>
            <TextInput
                style={styles.input}
                placeholder="Name"
                value={userProfile.name}
                onChangeText={(value) => handleInputChange('name', value)}
            />
            <TextInput
                style={styles.input}
                placeholder="Email"
                value={userProfile.email}
                onChangeText={(value) => handleInputChange('email', value)}
            />
            <Button title="Update Profile" onPress={handleUpdateProfile} />
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
        justifyContent: 'center',
    },
    title: {
        fontSize: 24,
        marginBottom: 20,
    },
    input: {
        height: 40,
        borderColor: 'gray',
        borderWidth: 1,
        marginBottom: 15,
        paddingHorizontal: 10,
    },
});

export default ProfileScreen;