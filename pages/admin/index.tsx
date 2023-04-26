import { useRouter } from "next/router";

export default function Admin() {
    const router = useRouter();
    router.push('/admin/profile');
}