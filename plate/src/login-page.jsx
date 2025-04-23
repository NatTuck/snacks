import {
  useForm, FormProvider, useFormContext
} from "react-hook-form";
import { FiAlertTriangle } from "react-icons/fi";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router";

import capitalize from "lodash/capitalize";

import { useStore } from "./store";

function LoginPage() {
  const [submitting, setSubmitting] = useState(false);
  const [loginError, setLoginError] = useState(null); // State for login errors
  const navigate = useNavigate();
  const session = useStore((store) => store.session);
  const loginAction = useStore((state) => state.login); // Get login action from store

  useEffect(() => {
    // Redirect if already logged in (check for token in session)
    if (session?.token) {
      navigate("/snacks");
    }
  }, [navigate, session]);

  const form = useForm({ mode: 'onChange' });
  const { handleSubmit, register } = form;

  async function onSubmit(data) {
    setSubmitting(true);
    setLoginError(null); // Clear previous errors
    try {
      // Call the login action from the store
      await loginAction(data.email, data.password);
      // Navigation happens via useEffect watching the session state
    } catch (error) {
      console.error("Login error in component:", error);
      // Use the error message from the ApiError or  a default
      setLoginError(error.message || "An error occurred during login.");
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <FormProvider {...form}>
      <form onSubmit={handleSubmit(onSubmit)}>
        {/* Added required validation */}
        <InputGroup name="email" emsg="Invalid email.">
          <input
            type="text" name="email"
            className="input input-neutral"
            {...register('email', { required: true, minLength: 4, pattern: /@/ })} />
        </InputGroup>

        {/* Corrected password input */}
        <InputGroup name="password" emsg="Min length 8.">
          <input
            type="password" name="password" // Correct name="password"
            className="input input-neutral"
            {...register('password', { required: true, minLength: 8 })} />
        </InputGroup>

        {/* Display Login Error */}
        {loginError && (
          <div className="flex my-2 items-center">
            <div className="w-16">&nbsp;</div>
            <div className="text-error flex items-center">
              <FiAlertTriangle className="mr-1" /> {loginError}
            </div>
          </div>
        )}

        <div className="flex my-2">
          <div className="w-24">&nbsp;</div>
          <div>
            <button
              type="submit" // Explicitly set type="submit"
              className="btn btn-primary"
              disabled={submitting}>
              {submitting ? "Logging In..." : "Log In"}
            </button>
          </div>
        </div>
      </form>
    </FormProvider>
  );
}

function InputGroup({ name, emsg, children }) {
  function StatusBadge() {
    const { formState } = useFormContext();
    // Use touchedFields to only show errors after interaction
    const { errors, touchedFields } = formState;

    // Show error only if the field is touched and has an error
    if (!touchedFields[name] || !errors[name]) {
      return null;
    }

    // Determine the specific error message based on validation type
    let specificEmsg = emsg; // Default message
    switch (errors[name]?.type) {
      case 'required':
        specificEmsg = `${capitalize(name)} is required.`;
        break;
      case 'minLength':
        // Assuming minLength value might be available in message or ref if set in register
        specificEmsg = `Minimum length is ${errors[name]?.ref?.minLength || 8}.`;
        break;
      case 'pattern':
        specificEmsg = `Invalid ${name} format.`;
        break;
      default:
        // Use default emsg if type is unknown or not set
        specificEmsg = emsg;
    }

    return (
      <div className="badge badge-outline badge-error mx-2 p-4 flex items-center">
        <FiAlertTriangle className="mr-1" /> {specificEmsg}
      </div>
    );
  }

  return (
    <div className="my-2 flex items-center">
      <div className="w-24 px-4">
        {capitalize(name)}
      </div>
      <div>
        {children}
      </div>
      {/* Render the status badge */}
      <StatusBadge />
    </div>
  );
}

export default LoginPage;
