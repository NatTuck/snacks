import { useForm } from "react-hook-form";

function LoginForm() {
  const { handleSubmit, register } = useForm();

  function onSubmit(data) {
    console.log("login", data);
  }

  return (
    <div>
      <form onSubmit={handleSubmit(onSubmit)}>
        <input type="email" className="input input-neutral"
          {...register('email', { pattern: /@/ })} />
        <input type="submit" className="btn btn-primary" />
      </form>
    </div>
  );
}

export default LoginForm;
