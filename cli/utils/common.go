package utils

// Contains checks whether the element exists in array or not
func Contains(arr []string, str string) bool {
	for _, a := range arr {
		if a == str {
			return true
		}
	}
	return false
}
var Confirmation = []string{"y", "Yes", "Y", "yes", "YES"}
var Refuse = []string{"N", "n", "no", "No", "NO"}