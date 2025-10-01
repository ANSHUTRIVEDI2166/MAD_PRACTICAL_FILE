import React, { useEffect, useState } from 'react';
import { View, Text, FlatList, Button, StyleSheet } from 'react-native';
import { getStudents } from '../database/sqlite';
import StudentItem from '../components/StudentItem';

const StudentListScreen = ({ navigation }) => {
    const [students, setStudents] = useState([]);

    useEffect(() => {
        fetchStudents();
    }, []);

    const fetchStudents = async () => {
        const studentList = await getStudents();
        setStudents(studentList);
    };

    const renderStudentItem = ({ item }) => (
        <StudentItem
            student={item}
            onEdit={() => navigation.navigate('EditStudent', { studentId: item.id })}
        />
    );

    return (
        <View style={styles.container}>
            <FlatList
                data={students}
                renderItem={renderStudentItem}
                keyExtractor={(item) => item.id.toString()}
            />
            <Button
                title="Add Student"
                onPress={() => navigation.navigate('AddStudent')}
            />
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 16,
    },
});

export default StudentListScreen;