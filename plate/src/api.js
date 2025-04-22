// Define the backend API base URL
const API_BASE_URL = "http://localhost:4000/api/v1";

// Custom error class for API errors
class ApiError extends Error {
  constructor(message, status) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
  }
}

/**
 * Handles the response from a fetch request.
 * Checks for errors, parses JSON, and throws ApiError on failure.
 * @param {Response} response - The fetch response object.
 * @returns {Promise<any>} - A promise that resolves with the JSON data.
 * @throws {ApiError} - Throws an error if the response status is not ok.
 */
async function handleApiResponse(response) {
  let responseData;
  try {
    // Try to parse JSON regardless of status, backend might send error details
    responseData = await response.json();
  } catch (e) {
    // If JSON parsing fails, use status text for non-ok responses
    if (!response.ok) {
      throw new ApiError(response.statusText || 'Unknown API error', response.status);
    }
    // If it was ok but JSON failed (e.g., empty body), maybe return null or handle differently
    // For now, let's assume successful responses always have valid JSON
    responseData = null; // Or handle as needed
  }

  if (!response.ok) {
    // Use message from parsed JSON error if available, otherwise default message
    const errorMessage = responseData?.errors?.detail || responseData?.error || 'API request failed';
    throw new ApiError(errorMessage, response.status);
  }

  // The backend /auth/login returns { data: { user: ..., token: ... } }
  // Extract the nested data object
  return responseData.data;
}

/**
 * Logs in a user via the API.
 * @param {string} email - The user's email.
 * @param {string} password - The user's password.
 * @returns {Promise<{user: object, token: string}>} - A promise resolving with user and token.
 * @throws {ApiError} - Throws an error on login failure.
 */
export async function loginUser(email, password) {
  const response = await fetch(`${API_BASE_URL}/auth/login`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: JSON.stringify({ email, password }),
  });

  return handleApiResponse(response); // Returns { user, token } on success
}

// Example of how to add other API functions later:
// export async function registerUser(email, password) { ... }
// export async function fetchSnacks(token) { ... }

