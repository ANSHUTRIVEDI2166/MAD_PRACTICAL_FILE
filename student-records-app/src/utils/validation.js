export const validateEmail = (email) => {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(String(email).toLowerCase());
};

export const validateRequiredField = (value) => {
    return value.trim() !== '';
};

export const validateStudentData = (student) => {
    const { name, email, age } = student;
    return (
        validateRequiredField(name) &&
        validateEmail(email) &&
        validateRequiredField(age) &&
        !isNaN(age) &&
        age > 0
    );
};