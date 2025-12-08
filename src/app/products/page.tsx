import { redirect } from 'next/navigation'

export default function ProductsRootRedirect() {
  redirect('/dashboard/products')
}

