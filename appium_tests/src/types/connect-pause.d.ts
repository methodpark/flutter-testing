declare module 'connect-pause' {
  import { NextHandleFunction } from "connect";

  export default function pause(delay?: number, err?: unknown): NextHandleFunction;
}
