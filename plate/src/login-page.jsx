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
  const navigate = useNavigate();
  const session = useStore((store) => store.session);

  useEffect(() => {
    if (session) {
      navigate("/snacks");
    }
  }, [navigate, session]);

  const form = useForm({ mode: 'onChange' });
  const { handleSubmit, register } = form;

  const setSession = useStore((state) => state.setSession);

  function onSubmit(data) {
    setSubmitting(true);
    window.setTimeout(() => {
      setSession(data);
    }, 1000);
  }

  return (
    <FormProvider {...form}>
      <form onSubmit={handleSubmit(onSubmit)}>
        <InputGroup name="email" emsg="Invalid email.">
          <input
            type="text" name="email"
            className="input input-neutral"
            {...register('email', { minLength: 4, pattern: /@/ })} />
        </InputGroup>

        <InputGroup name="pass" emsg="Min length 8.">
          <input
            type="password" name="email"
            className="input input-neutral"
            {...register('pass', { minLength: 8 })} />
        </InputGroup>

        <div className="flex my-2">
          <div className="w-16">&nbsp;</div>
          <div>
            <button
              className="btn btn-primary"
              disabled={submitting}>
              Log In
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
    const { errors, dirtyFields } = formState;

    if (!dirtyFields[name] || !errors[name]) {
      return "";
    }

    return (
      <div className="badge badge-outline badge-error mx-2 p-4">
        <FiAlertTriangle /> {emsg}
      </div>
    );
  }

  return (
    <div className="my-2 flex items-center">
      <div className="w-16 px-4">
        {capitalize(name)}
      </div>
      <div>
        {children}
      </div>
      <StatusBadge />
    </div>
  );
}

export default LoginPage;
