import React from 'react';
import { View, Text, Button, StyleSheet } from 'react-native';

const StudentItem = ({ student, onEdit, onDelete }) => {
    return (
        <View style={styles.container}>
            <Text style={styles.name}>{student.name}</Text>
            <Text style={styles.details}>Age: {student.age}</Text>
            <Text style={styles.details}>Email: {student.email}</Text>
            <View style={styles.buttonContainer}>
                <Button title="Edit" onPress={() => onEdit(student.id)} />
                <Button title="Delete" onPress={() => onDelete(student.id)} color="red" />
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        padding: 10,
        marginVertical: 5,
        backgroundColor: '#f9f9f9',
        borderRadius: 5,
        shadowColor: '#000',
        shadowOffset: {
            width: 0,
            height: 1,
        },
        shadowOpacity: 0.2,
        shadowRadius: 1.41,
        elevation: 2,
    },
    name: {
        fontSize: 18,
        fontWeight: 'bold',
    },
    details: {
        fontSize: 14,
        color: '#555',
    },
    buttonContainer: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginTop: 10,
    },
});

export default StudentItem;