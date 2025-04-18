import { FiAlertTriangle, FiCheck } from "react-icons/fi";

function LoginForm() {
  function onSubmit(data) {
    console.log("login", data);
  }

  return (
    <div>
      <form onSubmit={onSubmit}>
        <InputField type="text" name="email" />

        <div>
          <input type="submit" className="btn btn-primary" />
        </div>
      </form>
    </div>
  );
}

function InputField({name, type}) {
  type ||= "text";

  let badge = "";
  /*
  badge = (
    <div className="badge badge-outline badge-error mx-2 p-4">
      <FiAlertTriangle /> Email required.
    </div>
  );
  badge = (
    <div className="badge badge-outline badge-info mx-2 p-4">
      <FiCheck />
    </div>
  }
  */

  
  return (
    <div className="my-2">
      <input type={type} name={name} className="input input-neutral" />
      { badge }
    </div>
  );
}

export default LoginForm;
